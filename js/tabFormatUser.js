
const pages_btn = [document.querySelector('#dash-btn'),
document.querySelector('#issue-btn'),
document.querySelector('#issued-btn'),
document.querySelector('#return-btn'),
document.querySelector('#renew-btn')
];

const admin_pages = [document.querySelector('#user-dash'),
document.querySelector('#issue-books'),
document.querySelector('#issued-books'),
document.querySelector('#return-books'),
document.querySelector('#renew-books')
];
pages_btn.forEach((btn, index) => {
    btn.addEventListener('click', (e) => {
        // changes in the button;
        const active_btn = pages_btn.find((btn) => {
            if (btn.classList.contains('active-shadow')) {
                return true;
            }
            return false;
        });
        const now_active_btn = e.target;
        addRemove(active_btn, 'active-shadow', 'link-shadow');
        addRemove(now_active_btn, 'link-shadow', 'active-shadow');
        // changes in the pages;
        const active_page = admin_pages.find((page) => {
            if (page.classList.contains('d-block')) {
                return true;
            }
            return false;
        });
        const now_active_page = admin_pages[index];
        addRemove(active_page, 'd-block', 'd-none');
        addRemove(now_active_page, 'd-none', 'd-block');


    })
});

function addRemove(obj, toRem, toAdd) {
    obj.classList.remove(toRem);
    obj.classList.add(toAdd);
}




