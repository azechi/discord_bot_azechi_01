use std::env;

use serenity::{
    async_trait,
    model::{channel::Message, gateway::Ready},
    prelude::*,
};

use tokio::signal::unix::{signal, SignalKind};

struct Handler;

#[async_trait]
impl EventHandler for Handler {
    async fn message(&self, ctx: Context, msg: Message) {
        if msg.content == "!ping" {
            if let Err(why) = msg.channel_id.say(&ctx.http, "Pong!!").await {
                println!("Error sending message: {:?}", why);
            }
        }
    }

    async fn ready(&self, _: Context, ready: Ready) {
        println!("{} is connected!", ready.user.name);
    }
}

#[tokio::main]
async fn main() {

    {
        use std::process;
        println!("My pid is {}", process::id());
    }

    let token = env::var("BOT_TOKEN").expect("token");
    let mut client = Client::builder(&token)
        .event_handler(Handler)
        .await
        .expect("Err creating client");

    let shard_man = client.shard_manager.clone();

    let mut sigint = signal(SignalKind::interrupt()).expect("Could not register SIGINT handler");
    let mut sigterm = signal(SignalKind::terminate()).expect("Could not register SIGTERM handler");

    tokio::spawn(async move {
        tokio::select! {
            _ = sigint.recv() => println!("SIGINT"),
            _ = sigterm.recv() => println!("SIGTERM"),
        }
        shard_man.lock().await.shutdown_all().await;
    });

    if let Err(why) = client.start().await {
        println!("Client error: {:?}", why);
    } else {
        println!("Client shutdown.");
    }
}
