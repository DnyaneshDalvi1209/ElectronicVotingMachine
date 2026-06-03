module voter_lock(
    input valid_voter,
    input [2:0] voter_index,
    input cast_vote,
    output reg allow_vote
);

reg voted_flag [0:7];

integer i;

initial begin
    for(i = 0; i < 8; i = i + 1)
        voted_flag[i] = 0;
end

always @(*) begin
    if(valid_voter && voted_flag[voter_index] == 0)
        allow_vote = 1;
    else
        allow_vote = 0;
end

always @(posedge cast_vote) begin
    if(valid_voter && voted_flag[voter_index] == 0)
        voted_flag[voter_index] = 1;
end

endmodule