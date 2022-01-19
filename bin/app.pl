use Dancer2;

get "/" => sub{
    return "hello dancer2";
}; 
start;