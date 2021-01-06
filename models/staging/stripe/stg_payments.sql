select
    id as payment_id,
    orderid as order_id,
    amount,
    status as payment_status

from {{ source('stripe', 'payment')}}