// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

document.addEventListener('DOMContentLoaded', () => {
  const albumRows = document.querySelectorAll('.album-row');
  const modal = document.getElementById('album-modal');
  const title = document.getElementById('modal-title');
  const description = document.getElementById('modal-description');
  const image = document.getElementById('modal-image');
  const editButton = document.getElementById('edit-button');
  const editModal = document.getElementById('edit-user-modal');
  const newUserButton = document.getElementById('new-user-button');
  const closeModalButton = document.getElementById('close-album-modal');
  const newUserModal = document.getElementById('new-user-modal');
  const closeUserModalButton = document.getElementById('close-user-modal-button');
  const closeEditModalButton = document.getElementById('close-edit-modal-button');
  const searchField = document.getElementById('search-field');
  const searchForm = document.getElementById('search-form');

  let timeout;

  if (searchField && searchForm) {
    searchField.addEventListener('input', () => {
      clearTimeout(timeout);
      timeout = setTimeout(() => {
        searchForm.requestSubmit();
      }, 300);
    });
  }

  const showModal = (modal) => {
    if (modal) {
      modal.classList.remove('hidden');
    }
  };

  const hideModal = (modal) => {
    if (modal) {
      modal.classList.add('hidden');
    }
  };

  if (albumRows) {
    albumRows.forEach(row => {
      row.addEventListener('click', () => {
        const dataset = JSON.parse(row.dataset.album);
        title.innerText = dataset.title;
        description.innerText = dataset.info.title;
        image.src = dataset.info.url;
        showModal(modal);
      });
    });
  }

  if (closeModalButton) {
    closeModalButton.addEventListener('click', () => {
      hideModal(modal);
    });
  }

  if (closeUserModalButton) {
    closeUserModalButton.addEventListener('click', () => {
      hideModal(newUserModal);
    });
  }

  if (closeEditModalButton) {
    closeEditModalButton.addEventListener('click', () => {
      hideModal(editModal);
    });
  }

  if (editButton) {
    editButton.addEventListener('click', () => {
      showModal(editModal);
    });
  }

  if (newUserButton) {
    newUserButton.addEventListener('click', () => {
      showModal(newUserModal);
    });
  }
});
