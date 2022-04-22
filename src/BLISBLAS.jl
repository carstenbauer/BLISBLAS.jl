module BLISBLAS

using blis_jll
using LinearAlgebra

function get_num_threads()
    err = @ccall blis.bli_thread_get_num_threads()::Cint
    err == -1 && throw(ErrorException("return value was -1"))
    return nothing
end

function set_num_threads(nthreads)
    err = @ccall blis.bli_thread_set_num_threads(nthreads::Cint)::Cvoid
    err == -1 && throw(ErrorException("return value was -1"))
    return nothing
end

function __init__()
    if blis_jll.is_available()
        BLAS.lbt_forward(libblis, clear=true)
    else
        @warn("blis_jll artifact doesn't seem to be available for your platform!")
    end
end

end # module
