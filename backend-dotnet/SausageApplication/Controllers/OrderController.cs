using Microsoft.AspNetCore.Mvc;
using SausageApplication.Dto;
using SausageApplication.Services;

namespace SausageApplication.Controllers;

[ApiController]
[Route("api/orders")]
public class OrderController : Controller
{
    private readonly OrderService _orderService;

    public OrderController(OrderService orderService)
    {
        _orderService = orderService;
    }
    
    [HttpGet]
    [Route("getallorders")]
    public async Task<IActionResult> GetAllOrders()
    {
        var orders = await _orderService.GetAllOrders();
        return Ok(orders);
    }

    [HttpPost]
    public async Task<IActionResult> CreateOrder(OrderForm form)
    {
        var formDtos = form.ProductOrders;

        var order = await _orderService.CreateOrder(formDtos);
        return Ok(order);
    }
}