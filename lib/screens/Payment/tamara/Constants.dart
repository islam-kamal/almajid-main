const PAYMENT_URL = "https://sbcheckout.payfort.com/FortAPI/paymentPage";
//don't forgot to change order type column to 'mobile_android' in sales_order. this is for integration return url
const ORDER_DATA = {
  "url":"https://checkout-sandbox.tamara.co/checkout/d8c82615-a2cc-4483-a01d-eb8b2e23326a?locale=en_US&orderId=fe1d7da5-238c-4586-8fc5-bd917ad58d40",
};
const STATUS_LOADING = "PAYMENT_LOADING";
const STATUS_SUCCESSFUL = "PAYMENT_SUCCESSFUL";
const STATUS_PENDING = "PAYMENT_PENDING";
const STATUS_FAILED = "PAYMENT_FAILED";
const STATUS_CHECKSUM_FAILED = "PAYMENT_CHECKSUM_FAILED";
