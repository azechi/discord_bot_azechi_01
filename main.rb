require 'discordrb'

#bot = Discordrb::Bot.new(token: ENV['TOKEN'], log_mode: :debug) 
bot = Discordrb::Bot.new token: ENV["TOKEN"]

bot.message(with_text: 'Ping!') { |event| event.respond 'Pong!' }

bot.ready do |event|
	p event
end

Signal.trap(:TERM) { bot.stop(true) }
Signal.trap(:INT) { bot.stop(true) }

bot.run

