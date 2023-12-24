using SausageApplication.Models;

namespace SausageApplication.Dto;

public class OrderProductDto
{
    public Product Product { get; set; }
    public int Quantity { get; set; }
}