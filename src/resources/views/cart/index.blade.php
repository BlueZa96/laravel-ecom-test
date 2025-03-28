@extends('layouts.app')

@section('content')
    <div class="container">
        <h1 class="my-4">Ваша корзина</h1>
        @if((count($cart) <= 0))
            <p>Корзина пуста.</p>
        @else
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>Товар</th>
                        <th>Количество</th>
                        <th>Цена</th>
                        <th>Сумма</th>
                    </tr>
                </thead>
                <tbody>
                    @foreach ($cart as $id => $item)
                        <tr>
                            <td>{{ $item['name'] }}</td>
                            <td>{{ $item['quantity'] }} шт.</td>
                            <td>{{ $item['price'] }} руб.</td>
                            <td>{{ $item['price'] * $item['quantity'] }} руб.</td>
                        </tr>
                    @endforeach
                </tbody>
            </table>
            <form action="{{ route('cart.checkout') }}" method="POST">
                @csrf
                <button type="submit" class="btn btn-success">Оформить заказ</button>
            </form>
        @endif
        <a href="{{ route('products.index') }}" class="btn btn-secondary mt-3">Вернуться к товарам</a>
    </div>
@endsection
