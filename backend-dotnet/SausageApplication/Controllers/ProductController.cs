using Microsoft.AspNetCore.Mvc;
using SausageApplication.Models;
using SausageApplication.Services;

namespace SausageApplication.Controllers;

[ApiController]
[Route("api/products")]
public class ProductController : Controller
{
    private readonly ProductService _productService;

    public ProductController(ProductService productService)
    {
        _productService = productService;
    }

    //TODO: Сделать возможность брать или все продукты, или продукты по id, если он указан в GET запросе
    [HttpGet]
    [Route("getallproducts")]
    public async Task<IActionResult> GetProducts()
    {
        var products = await _productService.GetAllProducts();
        return Ok(products);
    }

    [HttpPost]
    public async Task<IActionResult> SaveProduct(Product product)
    {
        await _productService.SaveProduct(product);
        return Ok(product);
    }
}