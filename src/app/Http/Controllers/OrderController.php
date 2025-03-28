<?php

namespace App\Http\Controllers;
use App\Models\Order;

class OrderController extends Controller
{
    public function index()
    {
        $orders = Order::with('items.product')->get();
        return view('orders.index', compact('orders'));
    }

    public function destroy($id)
    {
        Order::findOrFail($id)->delete();
        return redirect()->route('orders.index')->with('success', 'Заказ удален');
    }
}