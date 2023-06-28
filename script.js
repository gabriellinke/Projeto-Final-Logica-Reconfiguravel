const fs = require('fs');

const fileStream = fs.createReadStream('input.dat', 'utf-8');
  fileStream.on('data', chunk => {
    const lines = chunk.split('\n');
	let i = 1;
    lines.forEach(line => {
      console.log(i++ + '\t' + convertTo32BitBinary(line) + '\n');
	  
    });
  });
  
  
function convertTo32BitBinary(number) {
  let binaryString = '';

  for (let i = 31; i >= 0; i--) {
    // Aplica uma máscara de bit para obter o valor do bit na posição atual
    let bit = (number & (1 << i)) ? '1' : '0';

    binaryString += bit;
  }

  return binaryString;
}