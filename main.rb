require 'discordrb'
require 'discordrb/cache'

bot = Discordrb::Bot.new(token: ENV["TOKEN"], log_mode: :debug)
#bot = Discordrb::Bot.new token: ENV["TOKEN"]
bot.message(with_text: 'Ping!') do |event|
	event.respond 'Pong!'
end

bot.ready do |event|
  voice = bot.voice_connect('380159851013210135')


  p "-------------------------------"
  voice.play_io('music.mp3')

  p "-------------------------------"

  #sleep 10


  p "-------------------------------"
  bot.voice_destory('380159850577133571')

  p "-------------------------------"
end

Signal.trap(:TERM) { bot.stop(true)}
Signal.trap(:INT) {bot.stop(true)}

bot.run

