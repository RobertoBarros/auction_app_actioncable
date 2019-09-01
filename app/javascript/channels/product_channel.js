import consumer from './consumer'

const ul = document.querySelector("[data-product-id]");

const initProductChannel = () => {
  if(ul){
    const productId = ul.dataset['productId'];
    subscription(productId);
  }
}

const subscription = (productId) => {
  consumer.subscriptions.create({channel: 'ProductChannel', id: productId },{
    received(data) {
      updateCurrentPrice(data.productPrice);
      addBid(data.bidHTML);
    },
    connected() {
      console.log('connected');
    }
  });
}

const addBid = (bidHTML) => {
  ul.insertAdjacentHTML('afterbegin', bidHTML);
}

const updateCurrentPrice = (productPrice) => {
  const span = document.getElementById('current-price');
  span.textContent = productPrice;
}

export { initProductChannel };