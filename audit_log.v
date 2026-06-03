module audit_log(
    input allow_vote,
    input cast_vote,
    input [2:0] voter_index,
    input [1:0] vote_sel,

    output reg [2:0] log_voter0, log_voter1, log_voter2, log_voter3,
    output reg [2:0] log_voter4, log_voter5, log_voter6, log_voter7,

    output reg [1:0] log_vote0, log_vote1, log_vote2, log_vote3,
    output reg [1:0] log_vote4, log_vote5, log_vote6, log_vote7
);

reg [2:0] log_ptr;

initial begin
    log_ptr = 0;
end

always @(posedge cast_vote) begin
    if (allow_vote) begin

        case(log_ptr)

        3'd0: begin log_voter0 = voter_index; log_vote0 = vote_sel; end
        3'd1: begin log_voter1 = voter_index; log_vote1 = vote_sel; end
        3'd2: begin log_voter2 = voter_index; log_vote2 = vote_sel; end
        3'd3: begin log_voter3 = voter_index; log_vote3 = vote_sel; end
        3'd4: begin log_voter4 = voter_index; log_vote4 = vote_sel; end
        3'd5: begin log_voter5 = voter_index; log_vote5 = vote_sel; end
        3'd6: begin log_voter6 = voter_index; log_vote6 = vote_sel; end
        3'd7: begin log_voter7 = voter_index; log_vote7 = vote_sel; end

        endcase

        log_ptr = log_ptr + 1;

    end
end

endmodule