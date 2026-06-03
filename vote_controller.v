module vote_controller(
    input allow_vote,
    input cast_vote,
    input [1:0] vote_sel,

    output reg [7:0] candidate_A_votes,
    output reg [7:0] candidate_B_votes,
    output reg [7:0] candidate_C_votes,
    output reg [7:0] nota_votes
);

initial begin
    candidate_A_votes = 0;
    candidate_B_votes = 0;
    candidate_C_votes = 0;
    nota_votes = 0;
end

always @(posedge cast_vote) begin

    if(allow_vote) begin

        case(vote_sel)

            2'b00: candidate_A_votes = candidate_A_votes + 1;

            2'b01: candidate_B_votes = candidate_B_votes + 1;

            2'b10: candidate_C_votes = candidate_C_votes + 1;

            2'b11: nota_votes = nota_votes + 1;

        endcase

    end

end

endmodule