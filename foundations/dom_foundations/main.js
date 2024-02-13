// console.log("Connected!");

const container = document.querySelector('#container');

const para = document.createElement('p');
para.textContent = "Hey I'm red!";
para.style.color = 'red';

container.appendChild(para);

const h3 = document.createElement('h3');
h3.textContent = "I'm a blue h3!";
h3.style.color = 'blue';

container.appendChild(h3);

const div = document.createElement('div');
div.style.border = '1px solid black';
div.style.backgroundColor = 'pink';

const h1 = document.createElement('h1');
h1.textContent = "I'm in a div";

div.appendChild(h1);

const p_2 = document.createElement('p');
p_2.textContent = "ME TOO!";

div.appendChild(p_2);

container.appendChild(div);

// ===

const button2 = document.querySelector('#button2');
button2.onclick = () => alert('Hello from button 2!');

const button3 = document.querySelector('#button3');
button3.addEventListener('click', () => {
    alert('Hello from button 3');
});

const alertFunction  = function() {
    alert('You triggered the alertFunction!');
};

const button4 = document.querySelector('#button4');
button4.addEventListener('click', alertFunction);

const button5 = document.querySelector('#button5');
button5.addEventListener('click', (e) => {
    console.log(e.target);
    e.target.innerText = 'CLICKED!!!';
    e.target.style.backgroundColor = 'green';
});
