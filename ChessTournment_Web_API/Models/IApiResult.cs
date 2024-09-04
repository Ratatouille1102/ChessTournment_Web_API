namespace ChessTournment_Web_API.Models
{
    public interface IApiResult<T>
    {
        T result { get; set; }
        int length { get; set; }
        int statusCode { get; set; }
    }
}
