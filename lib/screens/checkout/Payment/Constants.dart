const PAYMENT_URL = "https://sbcheckout.payfort.com/FortAPI/paymentPage";
//don't forgot to change order type column to 'mobile_android' in sales_order.
// this is for integration return url
const ORDER_DATA = {
  "website_domain":"https://test.almajed4oud.com/index.php",
  "orderId": 4697,
  "card_number": "4557012345678902",
  "card_holder_name": "Mohammed Abdelrasoul",
  "card_security_code": "123",
  "expiry_date": "2505",
};
const STATUS_LOADING = "PAYMENT_LOADING";
const STATUS_SUCCESSFUL = "PAYMENT_SUCCESSFUL";
const STATUS_PENDING = "PAYMENT_PENDING";
const STATUS_FAILED = "PAYMENT_FAILED";
const STATUS_CHECKSUM_FAILED = "PAYMENT_CHECKSUM_FAILED";
