require 'discordrb'

bot = Discordrb::Bot.new token: ENV["TOKEN"]
bot.message(with_text: 'Ping!') do |event|
	event.respond 'Pong!'
end

require 'thread'
mutex = Mutex.new
Signal.trap(:INT) do
	Thread.new { mutex.synchronize { bot.stop } }
end
#Signal.trap(:TERM) { bot.stop }

bot.run

