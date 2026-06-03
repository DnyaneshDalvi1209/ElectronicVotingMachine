module auth_tb;

reg [7:0] biometric_hash;
reg scan;

wire valid_voter;
wire [2:0] voter_index;

auth_module uut(
    .biometric_hash(biometric_hash),
    .scan(scan),
    .valid_voter(valid_voter),
    .voter_index(voter_index)
);

initial begin

    $dumpfile("auth_wave.vcd");
    $dumpvars(0,auth_tb);

    scan = 0;
    biometric_hash = 8'b00000000;

    #10;

    // Test 1 : valid voter
    scan = 1;
    biometric_hash = 8'b10110011;

    #20;

    // Test 2 : invalid voter
    biometric_hash = 8'b11111111;

    #20;

    // Test 3 : another valid voter
    biometric_hash = 8'b00110011;

    #20;

    scan = 0;

    #20 $finish;

end

endmodule