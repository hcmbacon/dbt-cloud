with payments as (

    select * from {{ ref('stg_payments')}}

),

orders as (

    select * from {{ ref('stg_orders') }}

),

success_payments as (
    select *
    from payments
    where payment_status like 'success'
),

total_payments as (
    select
        SUM(amount) as total_amount,
        order_id,
        
    from success_payments
    group by order_id
),

final as (

    select 
        order_id,
        customer_id,
        total_payments.total_amount,
        -- total_payments.payment_status,
    from orders
    join total_payments using (order_id)
)

select * from final