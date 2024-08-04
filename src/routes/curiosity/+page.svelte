<script lang='ts'>
	import CuriosityActivity from '$lib/Curiosity-activity.svelte'

	let video: HTMLVideoElement;
	let isPlaying = false;

	const videoSrc = '/curiosity.webm';

	const togglePlayPause = () => {
		if (video.paused) {
			video.play();
			isPlaying = true;
		} else {
			video.pause();
			isPlaying = false;
		}
	};

	const handlePlay = () => {
		isPlaying = true;
	};

	const handlePause = () => {
		isPlaying = false;
	};
</script>

<style>
	.video-container {
		position: relative;
		width: 100%;
		max-width: 600px;
		margin: 0 auto;
		background-color: transparent;
	}

	video {
		width: 100%;
		border-radius: 10px;
	}

	.controls {
		position: absolute;
		bottom: 10px;
		left: 50%;
		transform: translateX(-50%);
		display: flex;
		align-items: center;
		justify-content: center;
		background: rgba(0, 0, 0, 0.5);
		border-radius: 10px;
		padding: 5px;
	}

	.button {
		background: none;
		border: none;
		color: white;
		font-size: 16px;
		margin: 0 5px;
		cursor: pointer;
	}

	.button:hover {
		color: #ccc;
	}
</style>

<article>
	<p>
		At modality, curiosity is an innate instinct which is a key part of learning. How educators reveal knowledge is instrumental in the student's development of this instinct.
	</p>
	<div class="video-container">
		<video bind:this={video} on:play={handlePlay} on:pause={handlePause} class="bg-transparent">
			<source src={videoSrc} type="video/webm" />
			<track kind="captions">
		</video>
		<div class="controls">
			<div class="controls">
				{#if isPlaying}
					<button class="button" on:click={togglePlayPause}>⏸️</button>
				{:else}
					<button class="button" on:click={togglePlayPause}>▶️</button>
				{/if}
			</div>
		</div>
	</div>
	<CuriosityActivity/>
</article>