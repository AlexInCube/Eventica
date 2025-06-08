function ExampleStructListener() constructor{
    listener = "struct listener"
    
    EVENTICA_HANDLER.on("bruh", function(){
        show_debug_message($"hello from {listener}")
    })
}
