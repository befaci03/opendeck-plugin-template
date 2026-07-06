use openaction::*;

use serde::{Deserialize, Serialize};

#[derive(Serialize, Deserialize, Default, Clone)]
#[serde(default)]
struct CounterSettings {
	value: u32,
}

struct CounterAction;
#[async_trait]
impl Action for CounterAction {
	const UUID: ActionUuid = "com.example.opendeck.my-awesome-plugin";
	type Settings = CounterSettings;

	async fn key_up(
		&self,
		instance: &Instance,
		settings: &Self::Settings,
	) -> OpenActionResult<()> {
		let mut clone = settings.clone();
		clone.value = settings.value + 1;
		instance.set_settings(&clone).await?;
		instance.set_title(Some(clone.value.to_string()), None).await?;
        instance.show_ok().await
	}
}

#[tokio::main]
async fn main() -> OpenActionResult<()> {
	{
		use simplelog::*;
		if let Err(error) = TermLogger::init(
			LevelFilter::Debug,
			Config::default(),
			TerminalMode::Stdout,
			ColorChoice::Never,
		) {
			eprintln!("Logger initialization failed: {}", error);
		}
	}

	register_action(CounterAction).await;

	run(std::env::args().collect()).await
}
