module evm_system_tb;

reg [7:0] biometric_hash;
reg scan;
reg cast_vote;
reg [1:0] vote_sel;

wire valid_voter;
wire [2:0] voter_index;
wire allow_vote;

wire [7:0] candidate_A_votes;
wire [7:0] candidate_B_votes;
wire [7:0] candidate_C_votes;
wire [7:0] nota_votes;

/*audit log wires*/
wire [2:0] log_voter0, log_voter1, log_voter2, log_voter3, log_voter4, log_voter5, log_voter6, log_voter7;
wire [1:0] log_vote0, log_vote1, log_vote2, log_vote3, log_vote4, log_vote5, log_vote6, log_vote7;

/* result file handle */
integer file;

/* Authentication */

auth_module auth(
    .biometric_hash(biometric_hash),
    .scan(scan),
    .valid_voter(valid_voter),
    .voter_index(voter_index)
);

/* Voter Lock */

voter_lock lock(
    .valid_voter(valid_voter),
    .voter_index(voter_index),
    .cast_vote(cast_vote),
    .allow_vote(allow_vote)
);

/* Vote Controller */

vote_controller vote(
    .allow_vote(allow_vote),
    .cast_vote(cast_vote),
    .vote_sel(vote_sel),
    .candidate_A_votes(candidate_A_votes),
    .candidate_B_votes(candidate_B_votes),
    .candidate_C_votes(candidate_C_votes),
    .nota_votes(nota_votes)
);

/* Audit Log */

audit_log audit(
    .allow_vote(allow_vote),
    .cast_vote(cast_vote),
    .voter_index(voter_index),
    .vote_sel(vote_sel),

    .log_voter0(log_voter0), .log_voter1(log_voter1),
    .log_voter2(log_voter2), .log_voter3(log_voter3),
    .log_voter4(log_voter4), .log_voter5(log_voter5),
    .log_voter6(log_voter6), .log_voter7(log_voter7),

    .log_vote0(log_vote0), .log_vote1(log_vote1),
    .log_vote2(log_vote2), .log_vote3(log_vote3),
    .log_vote4(log_vote4), .log_vote5(log_vote5),
    .log_vote6(log_vote6), .log_vote7(log_vote7)
);

initial begin

    $dumpfile("evm_wave.vcd");
    $dumpvars(0,evm_system_tb);

    scan = 0;
    cast_vote = 0;
    vote_sel = 0;

    #10;

    /* Voter 0 votes Candidate A */

    scan = 1;
    biometric_hash = 8'b10110011;
    vote_sel = 2'b00;

    #20;

    cast_vote = 1;
    #10;
    cast_vote = 0;

    #30;

    /* Voter 3 votes Candidate B */

    biometric_hash = 8'b00110011;
    vote_sel = 2'b01;

    #20;

    cast_vote = 1;
    #10;
    cast_vote = 0;

    #30;

    /* Voter 4 votes Candidate B */

    biometric_hash = 8'b11100011;
    vote_sel = 2'b01;

    #20;

    cast_vote = 1;
    #10;
    cast_vote = 0;

    #30;
/* Invalid Voter  */

    biometric_hash = 8'b01100110;
    vote_sel = 2'b01;

    #20;

    cast_vote = 1;
    #10;
    cast_vote = 0;

    #30;

    /* Voter 1 votes NOTA */

    biometric_hash = 8'b01010101;
    vote_sel = 2'b11;

    #20;

    cast_vote = 1;
    #10;
    cast_vote = 0;

    #30;

    /* Voter 3 tries to vote again */

    biometric_hash = 8'b00110011;
    vote_sel = 2'b10;

    #20;

    cast_vote = 1;
    #10;
    cast_vote = 0;

    #50;

    /* Write results to file */

    file = $fopen("results.txt","w");

    $fdisplay(file,"CandidateA=%d", candidate_A_votes);
    $fdisplay(file,"CandidateB=%d", candidate_B_votes);
    $fdisplay(file,"CandidateC=%d", candidate_C_votes);
    $fdisplay(file,"NOTA=%d", nota_votes);

    $fclose(file);

    #10 $finish;

end

endmodule