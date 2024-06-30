import { writable } from 'svelte/store';

export const correctLetters = writable<string[]>([]);
export const incorrectLetters = writable<string[]>([]);