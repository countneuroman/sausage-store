using Microsoft.EntityFrameworkCore;
using SausageApplication.Infrastructure;
using SausageApplication.Models;

namespace SausageApplication.Services;

public class ProductService
{
    private readonly SausageContext _sausageContext;

    public ProductService(SausageContext sausageContext)
    {
        _sausageContext = sausageContext;
    }

    public async Task<List<Product>> GetAllProducts()
    {
        var products = await _sausageContext.Products.ToListAsync();
        return products;
    }

    public async Task<Product> GetProductById(long id)
    {
        var product = await _sausageContext.Products.FindAsync(id);
        if (product == null)
            throw new ApplicationException("Product not found!");
        return product;
    }
    
    public async Task<Product> SaveProduct(Product product)
    {
        await _sausageContext.Products.AddAsync(product);
        //TODO: Добавить проверОЧКИ на успешность
        return product;
    }
}