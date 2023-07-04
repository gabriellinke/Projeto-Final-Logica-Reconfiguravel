const tone = require('tonegenerator');
const header = require('waveheader');
const {createWriteStream} = require('fs');

let samples = [];
let lengthInSecs = 2;
let freqs = [1, 2, 3];

const makeChannel = () => {
    let waves = [];
    for(var i = 0; i < freqs.length; i++){
        waves.push(tone({ freq: freqs[i], lengthInSecs: lengthInSecs, volume: tone.MAX_16 / freqs.length, rate: 44100,  shape: 'sine' }))
    }
    for (var i = 0; i < waves[0].length; i++) {
        var total = 0;
        for(var j=0; j < waves.length; j++){
            total += waves[j][i];
        }
        samples.push(total)
    }
};
makeChannel()

let file = createWriteStream('input.wav');

file.write(header(samples.length * 2, {
    bitDepth: 16
}));

const data = Int16Array.from(samples);

const size = data.length * 2;

const buffer = new Buffer.alloc(size);

data.forEach((value, index) => {
    buffer.writeInt16LE(value, index * 2)
});

file.write(buffer);
file.end();

