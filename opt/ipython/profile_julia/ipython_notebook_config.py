# Configuration file for ipython-notebook.

c = get_config()

#------------------------------------------------------------------------------
# NotebookApp configuration
#------------------------------------------------------------------------------

# The IP address the notebook server will listen on.
c.NotebookApp.ip = '127.0.0.1'

# The base URL for the notebook server
c.NotebookApp.base_url = '/ijulia/'

# The base URL for the kernel server
c.NotebookApp.base_kernel_url = '/ijulia/'

# The base URL for websockets
c.NotebookApp.ws_url = '/ijulia/'

# The port the notebook server will listen on.
c.NotebookApp.port = 8888

# Supply overrides for the tornado.web.Application that the IPython notebook
# uses.
c.NotebookApp.webapp_settings = {'static_url_prefix':'/ijulia/static/'}

