<?php

namespace App\Http\Controllers;
use App\Models\Product;
use App\Models\Order;
use App\Models\OrderItem;
use Illuminate\Http\Request;

class CartController extends Controller
{
    public function add(Request $request, $productId)
    {
        $product = Product::findOrFail($productId);
        $quantity = $request->input('quantity', 1);

        $cart = session()->get('cart', []);
        $cart[$productId] = [
            'name' => $product->name,
            'price' => $product->price,
            'quantity' => isset($cart[$productId]) ? $cart[$productId]['quantity'] + $quantity : $quantity,
        ];
        session()->put('cart', $cart);

        return redirect()->route('cart.show');
    }

    public function show()
    {
        $cart = session()->get('cart', []);
        return view('cart.index', compact('cart'));
    }

    public function checkout()
    {
        $cart = session()->get('cart', []);
        if (empty($cart)) {
            return redirect()->route('products.index')->with('error', 'Корзина пуста');
        }

        $order = Order::create([
            'total_price' => array_sum(array_column($cart, 'price')),
        ]);

        foreach ($cart as $productId => $details) {
            OrderItem::create([
                'order_id' => $order->id,
                'product_id' => $productId,
                'quantity' => $details['quantity'],
                'subtotal' => $details['price'] * $details['quantity'],
            ]);
        }

        session()->forget('cart');
        return redirect()->route('orders.index')->with('success', 'Заказ успешно оформлен');
    }
}
