require 'discordrb'

bot = Discordrb::Bot.new token: ENV["DISCORD_BOT_TOKEN_AZECHI_BOT_01"]
bot.message(with_text: 'Ping!') do |event|
	event.respond 'Pong!'
end
bot.run

