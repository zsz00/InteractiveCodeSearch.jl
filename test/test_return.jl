module TestReturn

include("preamble.jl")
using InteractiveCodeSearch: seenkey

@testset "seenkey" begin
    @testset for x in [
                sin,
                Base,
                Array,
                Vector,
                Union{AbstractArray{T,1}, AbstractArray{T,2}} where T,
                Union{Int, Bool},
            ]
        @test_nothrow seenkey(x)
    end
end

@testset "@searchreturn" begin
    s = @eval @searchreturn Vector Pkg
    @test_nothrow @time wait(s.task)

    s = @eval @searchreturn Bool Base
    kill(s)
    _, t = @timed wait(s.task)
    @test t < 0.5
end

end  # module