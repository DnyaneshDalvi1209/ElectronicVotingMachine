module voter_lock_tb;

reg valid_voter;
reg [2:0] voter_index;
reg cast_vote;

wire allow_vote;

/* instantiate module */

voter_lock uut(
    .valid_voter(valid_voter),
    .voter_index(voter_index),
    .cast_vote(cast_vote),
    .allow_vote(allow_vote)
);

initial begin

    $dumpfile("voter_lock_wave.vcd");
    $dumpvars(0,voter_lock_tb);

    valid_voter = 0;
    voter_index = 3'b000;
    cast_vote = 0;

    #10;

    // valid voter arrives
    valid_voter = 1;
    voter_index = 3'b011;   // voter 3

    #20;

    // voter presses vote button
    cast_vote = 1;
    #10;
    cast_vote = 0;

    #20;

    // voter tries to vote again
    valid_voter = 1;
    voter_index = 3'b011;

    #20;

    // tries pressing vote again
    cast_vote = 1;
    #10;
    cast_vote = 0;

    #30 $finish;

end

endmodule