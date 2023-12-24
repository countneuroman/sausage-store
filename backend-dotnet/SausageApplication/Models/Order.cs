namespace SausageApplication.Models;

public class Order
{
    public long Id { get; set; }
    public string Status { get; set; }
    public DateOnly DateCreated { get; set; }
    public List<Product> Products { get; } = new();
    public List<OrderProduct> OrderProducts { get; } = new();
}