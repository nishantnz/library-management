const editBtn = document.querySelectorAll('.edit');
const delBtn = document.querySelectorAll('.del');

const screen_cover = document.querySelector('#cover-screen');
const modal = document.querySelector('#modal');

const bookid = document.getElementById('bookidmod');
const bookname = document.getElementById('booknamemod');
const authorname = document.getElementById('authornamemod');
const quantity = document.getElementById('quantitymod');

editBtn.forEach((btn) =>{//action for edit
    btn.addEventListener('click',(e)=>{
        screen_cover.classList.remove('d-none');
        screen_cover.classList.add('d-block');
        modal.classList.remove('d-none');
        modal.classList.add('d-block');
        const row = e.target.parentElement.parentElement;
        bookid.value = row.children[0].textContent;
        bookname.value = row.children[1].textContent;
        authorname.value = row.children[2].textContent;
        quantity.value = row.children[3].textContent;

    });
});
delBtn.forEach((btn) =>{//action for edit
    btn.addEventListener('click',(e)=>{
        console.log('it works');
    })
});