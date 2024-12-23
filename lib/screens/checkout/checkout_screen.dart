import 'package:flutter/material.dart';
import 'package:pizza_app/cart_related/cart_provider.dart';
import 'package:provider/provider.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Оплата',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            Text(
              'PIZZA RAY',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ),
      body: const CheckoutBody(),
    );
  }
}

class CheckoutBody extends StatelessWidget {
  const CheckoutBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DeliveryAddressSection(),
                  SizedBox(height: 24),
                  CourierCommentSection(),
                  SizedBox(height: 24),
                  PromoCodeSection(),
                  SizedBox(height: 24),
                  PaymentMethodSection(),
                  SizedBox(height: 24),
                  OrderSummarySection(),
                ],
              ),
            ),
          ),
        ),
        ConfirmOrderButton(),
      ],
    );
  }
}

class DeliveryAddressSection extends StatelessWidget {
  const DeliveryAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Адрес доставки',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: theme.primary,
                  ),
                  const SizedBox(width: 8),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '17-й квартал, 44',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      Text(
                        'Ташкент',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  const Spacer(),
                  const Icon(Icons.chevron_right),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildAddressDetail('Подъезд', '5'),
                  _buildAddressDetail('Этаж', '3'),
                  _buildAddressDetail('Кв./Офис', '57'),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAddressDetail(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}

class CourierCommentSection extends StatelessWidget {
  const CourierCommentSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          decoration: InputDecoration(
            hintText: 'Комментарий для курьера',
            filled: true,
            fillColor: Colors.grey[100],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
          maxLines: 1,
        ),
      ],
    );
  }
}

class PromoCodeSection extends StatelessWidget {
  const PromoCodeSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(
            Icons.confirmation_number_outlined,
            color: theme.primary,
          ),
          const SizedBox(width: 8),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Есть промокод?',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              Text(
                'Выберите или введите новый',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
          const Spacer(),
          const Icon(Icons.chevron_right),
        ],
      ),
    );
  }
}

class PaymentMethodSection extends StatefulWidget {
  const PaymentMethodSection({super.key});

  @override
  State<PaymentMethodSection> createState() => _PaymentMethodSectionState();
}

class _PaymentMethodSectionState extends State<PaymentMethodSection> {
  String selectedPayment = 'card';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Способ оплаты',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildPaymentOption(
                'Картой',
                theme.primary,
                'card',
                discount: 'Скидка 2 000 сум',
                //isSelected: true,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildPaymentOption(
                'Наличными',
                theme.primary,
                'cash',
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          'Можно оформить карту и оплатить заказ прямо сейчас — в приложении Uzum Bank',
          style: TextStyle(color: Colors.grey[600], fontSize: 13),
        ),
      ],
    );
  }

  Widget _buildPaymentOption(String title, Color color, String paymentType,
      {String? discount}) {
    final isSelected = selectedPayment == paymentType;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPayment = paymentType;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: isSelected ? color : Colors.grey[300]!,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.credit_card, color: color),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            if (discount != null)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.red[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  discount,
                  style: TextStyle(color: Colors.red[700], fontSize: 12),
                ),
              )
            else
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                child: const Text(''),
              ),
          ],
        ),
      ),
    );
  }
}

class OrderSummarySection extends StatelessWidget {
  const OrderSummarySection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final cart = Provider.of<CartProvider>(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('К оплате',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text(
                '${cart.totalAmount.toStringAsFixed(2)} сум',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: theme.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildSummaryRow(
            'Заказ',
            '${cart.totalAmount.toStringAsFixed(2)} сум',
          ),
          _buildSummaryRow('Скидка\n2 000 при оплате картой', '- 2 000 сум',
              isDiscount: true),
          _buildSummaryRow('Доставка', '5 000 сум'),
          _buildSummaryRow('Работа сервиса', '6 000 сум'),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value,
      {bool isDiscount = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.grey[600])),
          Text(
            value,
            style: TextStyle(
              color: isDiscount ? Colors.orange : Colors.grey[600],
              fontWeight: isDiscount ? FontWeight.w500 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

class ConfirmOrderButton extends StatelessWidget {
  const ConfirmOrderButton({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: theme.primary,
          minimumSize: const Size(double.infinity, 56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: const Text(
          'Отправить заказ',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
