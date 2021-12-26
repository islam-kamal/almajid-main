const PAYMENT_URL = "https://sbcheckout.payfort.com/FortAPI/paymentPage";
//don't forgot to change order type column to 'mobile_android' in sales_order. this is for integration return url
const ORDER_DATA = {
  "url":"https://test.almajed4oud.com/en-kw/tap/Standard/Redirect",
  "order_id": "ON50000206065",
  "token": "tok_9SUK402184872rZ15hg11a207",
};
const STATUS_LOADING = "PAYMENT_LOADING";
const STATUS_SUCCESSFUL = "PAYMENT_SUCCESSFUL";
const STATUS_PENDING = "PAYMENT_PENDING";
const STATUS_FAILED = "PAYMENT_FAILED";
const STATUS_CHECKSUM_FAILED = "PAYMENT_CHECKSUM_FAILED";
