# 💳 Checkout Payment App
A complete Flutter-based payment app that integrates Stripe and PayPal, focusing on delivering a smooth and secure checkout experience for users.


---


## 🚀 Overview
This project was built as a practical implementation of modern payment workflows in real-world applications.
It allows users to:

* Perform secure payments using Stripe or PayPal

- Customize items, prices, and transaction details

- Benefit from faster checkout using stored card data

 ---
  
## 🔐 Why Ephemeral Key?
To enhance the Stripe payment experience, the app uses an Ephemeral Key, which binds the session to the current authenticated customer.
This enables returning users to skip re-entering their card details each time, allowing a faster and more seamless checkout flow—just like production-ready apps.

---


## 🧩 Features
- Stripe Integration

- Create Payment Intents

- Generate Ephemeral Keys

- Handle client-side payment confirmation

- PayPal Integration

- Demo implementation using PayPal Sandbox

- Dynamic Item List

- Add and update items with prices

- Automatically calculate total and tax breakdown

- Code Structure

- Clean separation of concerns

- Modular and extendable architecture

  ---

## 📁 Project Structure
<pre>
lib/
├── main.dart
├── core/
│   ├── errors/
│   │   └── failure.dart
│   ├── functions/
│   │   └── get_transctions.dart
│   ├── utils/
│   │   ├── api_secret_key.dart
│   │   ├── api_service.dart
│   │   ├── stripe_service.dart
│   │   └── styles.dart
│   └── widgets/
│       ├── custom_button.dart
│       └── cutom_app_bar.dart
├── Features/
│   └── checkout/
│       ├── data/
│       │   ├── models/
│       │   │   ├── init_payment_sheet_input_model.dart
│       │   │   ├── payment_intent_input_model.dart
│       │   │   ├── amount_model/
│       │   │   ├── ephemeral_key_model/
│       │   │   ├
</pre>

The structure follows clear layering to isolate UI, business logic, and data handling — ensuring 

---

## 🧠 Tech Stack

| Purpose                | Technology        |
|------------------------|------------------|
| UI                     | Flutter           |
| Payment Gateway        | Stripe, PayPal    |
| HTTP Communication     | Dio               |
| State Management       | Cubit (Bloc)      |
| Architecture Pattern   | Layered / Modular |

---
## ⚙️ Getting Started
<pre>
git clone https://github.com/Omarelnasherty/checkout_payment.git
cd checkout_payment
flutter pub get
flutter run
</pre>

---

## 📌 Notes
- Stripe integration relies on a backend server (already configured and connected).

- PayPal implementation is set to Sandbox mode for demonstration purposes only.

- Card details are handled securely, and session-specific data ensures a better user experience on repeat transactions.

--- 

