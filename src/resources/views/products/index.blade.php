@extends('layouts.app')

@section('content')
    <div class="container">
        <a href="{{ route('cart.show') }}" class="btn btn-success" style="position: fixed; right: 50px; displaytop: 50px;">Перейти в корзину</a>
        <h1 class="my-4">Наши товары</h1>
        <div class="row">
            @foreach ($products as $product)
                <div class="col-md-4">
                    <div class="card mb-4 shadow-sm">
                        <div class="card-body">
                            <h5 class="card-title">{{ $product->name }}</h5>
                            <p class="card-text">{{ $product->price }} руб.</p>
                            <form action="{{ route('cart.add', $product->id) }}" method="POST">
                                @csrf
                                <div class="form-group">
                                    <label for="quantity">Количество</label>
                                    <div style="display: flex; height: 30px; width: 60%; gap: 10px;">
                                        <input type="number" name="quantity" class="form-control" style="width: 50px;" value="1" min="1">
                                        <button type="submit" class="btn btn-primary" style="padding:  0 5px 0 5px;">Добавить в корзину</button>
                                    </div>                                    
                                </div>
                                
                            </form>
                        </div>
                    </div>
                </div>
            @endforeach
        </div>
        
    </div>
@endsection
