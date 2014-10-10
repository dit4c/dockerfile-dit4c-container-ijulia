# DOCKER-VERSION 1.0
FROM dit4c/dit4c-container-base
MAINTAINER t.dettrick@uq.edu.au

RUN cd /etc/yum.repos.d && \
  wget https://copr.fedoraproject.org/coprs/nalimilan/julia/repo/epel-7/nalimilan-julia-epel-7.repo && \
  cd -

# Install
# - build dependencies for Python PIP
# - virtualenv to setup python environment
# - julia
# - ijulia dependencies
# and copied from iPython image, because they might be useful:
# - matplotlib dependencies
# - scipy dependencies
# - pytables dependencies
# - netcdf4 dependencies
# - nltk dependencies
RUN yum install -y \
  gcc python-devel \
  python-virtualenv \
  julia \
  nettle \
  libpng-devel freetype-devel \
  hdf5-devel \
  netcdf-devel \
  libyaml-devel

# Install system-indepedent python environment
RUN virtualenv /opt/python

# Install from PIP
# - Notebook dependencies
# - iPython (with notebook)
# - Readline for usability
RUN /opt/python/bin/pip install --upgrade setuptools && \
  /opt/python/bin/pip install \
    tornado pyzmq jinja2 \
    ipython \
    pyreadline

# Create IJulia profile, then
# install MathJAX locally because CDN is HTTP-only
RUN mkdir -p /opt/ipython /opt/julia && \
  source /opt/python/bin/activate && \
  IPYTHONDIR=/opt/ipython JULIA_PKGDIR=/opt/julia julia -e 'Pkg.init(); Pkg.add("IJulia")' && \
  /opt/python/bin/python -c "from IPython.external.mathjax import install_mathjax; install_mathjax()" && \
  chown -R researcher /opt/python /opt/ipython

# Add supporting files (directory at a time to improve build speed)
COPY etc /etc
COPY opt /opt
COPY var /var
# Chowned to root, so reverse that change
RUN chown -R researcher /opt/{,i}python /opt/julia /var/log/{easydav,supervisor}

# Check nginx config is OK
RUN nginx -t