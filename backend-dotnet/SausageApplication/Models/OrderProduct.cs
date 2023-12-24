namespace SausageApplication.Models;

public class OrderProduct
{
    public int Quantity { get; set; }
    public long ProductId { get; set; }
    public long OrderId { get; set; }
}