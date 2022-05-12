
const pages_btn = [document.querySelector('#dash-btn'),
                   document.querySelector('#add-btn'),
                   document.querySelector('#update-btn'),
                   document.querySelector('#view-btn'),
                   document.querySelector('#issued-btn')
                  ];

const admin_pages = [document.querySelector('#admin-dash'),
                     document.querySelector('#add-books'),
                     document.querySelector('#update-books'),
                     document.querySelector('#view-books'),
                     document.querySelector('#issued-books')
                    ];
pages_btn.forEach((btn, index) =>{
    btn.addEventListener('click',(e)=>{
        // changes in the button;
        const active_btn = pages_btn.find((btn) => {
            if(btn.classList.contains('active-shadow')){
                return true;
            }
            return false;
        });
        const now_active_btn = e.target;
        addRemove(active_btn,'active-shadow', 'link-shadow');
        addRemove(now_active_btn, 'link-shadow', 'active-shadow');
        // changes in the pages;
        const active_page = admin_pages.find((page) => {
            if(page.classList.contains('d-block')){
                return true;
            }
            return false;
        });
        const now_active_page = admin_pages[index];
        addRemove(active_page, 'd-block', 'd-none');
        addRemove(now_active_page, 'd-none', 'd-block');
        
        
    })
});

function addRemove(obj, toRem, toAdd){
    obj.classList.remove(toRem);
    obj.classList.add(toAdd);
}
                



