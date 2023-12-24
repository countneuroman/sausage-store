using Microsoft.EntityFrameworkCore;
using SausageApplication.Dto;
using SausageApplication.Infrastructure;
using SausageApplication.Models;

namespace SausageApplication.Services;

public class OrderService
{
    private readonly SausageContext _sausageContext;
    private readonly ProductService _productService;

    public OrderService(SausageContext sausageContext, ProductService productService)
    {
        _sausageContext = sausageContext;
        _productService = productService;
    }

    public async Task<List<Order>> GetAllOrders()
    {
        var products = await _sausageContext.Orders.ToListAsync();
        return products;
    }

    public async Task CreateOrder(List<OrderProductDto> formDtos)
    {
        var order = new Order();
        order.Status = OrderStatus.Paid.ToString();
        foreach (var orderProductDto in formDtos)
        {
            var product = await _productService.GetProductById(orderProductDto.Product.Id);
            order.Products.Add(product);
        }

        await _sausageContext.Orders.AddAsync(order);
        await _sausageContext.SaveChangesAsync();
    }
}