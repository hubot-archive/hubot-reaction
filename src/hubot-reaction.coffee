# Description:
#   https://github.com/jakswa/hubot-reaction
# 
# Configuration:
#   None
# 
# Commands:
#   !reply tag - returns reaction gif from replygif.net, with that tag
# 
# Author:
#   jakswa 
request = require('request')
cheerio = require('cheerio')
format = require('util').format
module.exports = (robot) ->
  robot.parseReplyGifTag = (text) ->
    text.toLowerCase().replace(/[^\w \-]+/g, '').replace(/--+/g, '').replace(/\ /g, '-')
  robot.hear /^!reply (.+)$/, (msg) ->
    tag = robot.parseReplyGifTag msg.match[1]
    request format('http://replygif.net/t/%s', tag), (err, resp, body) ->
      gifs = cheerio.load(body)('img.gif')
      if gifs.length == 0
        robot.send {user: msg.message.user}, "no gifs for #{tag} -- probably invalid category/tag"
      else
        ind = Math.floor(Math.random() * gifs.length)
        msg.send gifs.eq(ind).attr('src').replace('thumbnail', 'i')
  robot.hear /\?reply/, (msg) ->
    robot.send {user: msg.message.user}, "stuff" # TODO: this part
