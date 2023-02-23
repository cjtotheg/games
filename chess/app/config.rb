###
# set to true if you want to see more information printed to the console
###
VERBOSE = true #this will print everything
PRINT_BOARD_EVERY_MOVE = true
PRINT_PIECES_EVERY_MOVE = true

###
# Log
require 'logger'
LOG = Logger.new('chess.log')
LOG.datetime_format = '%y%m%d %H:%M:%S' #'%Y-%m-%d %H:%M:%S'
LOG.level = :info
