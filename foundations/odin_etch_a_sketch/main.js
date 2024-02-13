const container = document.querySelector('#container');
const buildGridButton = document.querySelector('#build-grid');

buildGridButton.addEventListener('click', () => {
  clearGrid();
  buildGrid(getGridSize());
});

function clearGrid() {
  while (container.firstChild) {
    container.removeChild(container.firstChild);
  }
}

function getGridSize() {
  const minGridSize = 10;
  const maxGridSize = 100;
  const gridSize = parseInt(prompt(`Enter grid size between ${minGridSize} and ${maxGridSize}`));
  
  if (gridSize < minGridSize || gridSize > maxGridSize) {
    alert(`number must be between ${minGridSize}-${maxGridSize}`);
    return getGridSize();
  }
  
  return gridSize;
}

function buildGrid(gridSize) {
  const grid = document.createElement('div');
  grid.id = 'grid';
  
  for (let i = 0; i < gridSize; i++) {
    const row = document.createElement('div');
    row.classList.add('row');
    
    for (let j = 0; j < gridSize; j++) {
      const square = document.createElement('div');
      square.classList.add('square');
      const id = `${i}-${j}`;
      square.id = `square-${id}`;
      square.textContent = '';
      
      square.addEventListener('mouseenter', () => { setBackgroundColor(square) });
      
      row.appendChild(square);            
    }
    
    grid.appendChild(row);
  }
  
  container.appendChild(grid);
}

function setBackgroundColor(square) {
  const colorSelector = document.querySelector('input[name="color-selector"]:checked').id;
  
  let red = 255;
  let green = 255;
  let blue = 255;
  
  switch (colorSelector) {
    case 'color-black':
      square.style.backgroundColor = 'black';
      break;
    case 'color-progressive-black':
      const currentColor = square.computedStyleMap().get('background-color').toString();
      [red, green, blue] = currentColor.match(/\d+/g);

      red = Math.max(red - 25, 0);
      green = Math.max(green - 25, 0);
      blue = Math.max(blue - 25, 0);

      square.style.backgroundColor = `rgb(${red}, ${green}, ${blue})`;
      break;
    case 'color-randomize':
      red = Math.floor(Math.random() * 255);
      green = Math.floor(Math.random() * 255);
      blue = Math.floor(Math.random() * 255);
      
      square.style.backgroundColor = `rgb(${red}, ${green}, ${blue})`;
      break;
    default:
      square.style.backgroundColor = 'black';
  }
}
