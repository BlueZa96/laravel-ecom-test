@extends('layouts.app')

@section('content')
    <div class="container">
        <h1 class="my-4">Ваши заказы</h1>
        @if($orders->isEmpty())
            <p>У вас нет заказов.</p>
            <a href="{{ route('products.index') }}" class="btn btn-secondary mt-3">Вернуться к товарам</a>
        @else
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>Номер заказа</th>
                        <th>Дата</th>
                        <th>Товары</th>
                        <th>Общая стоимость</th>
                        <th>Действие</th>
                    </tr>
                </thead>
                <tbody>
                    @foreach ($orders as $order)
                        <tr>
                            <td>{{ $order->id }}</td>
                            <td>{{ $order->created_at }}</td>
                            <td>{{ implode(', ', $order->items->pluck('product.name')->toArray()) }}</td>
                            <td>{{ $order->total_price }} руб.</td>
                            <td>
                                <form action="{{ route('orders.destroy', $order->id) }}" method="POST">
                                    @csrf
                                    @method('DELETE')
                                    <button type="submit" class="btn btn-danger btn-sm">Удалить</button>
                                </form>
                            </td>
                        </tr>
                    @endforeach
                </tbody>
            </table>
        @endif
    </div>
@endsection
