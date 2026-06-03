/*Database*/
module auth_module(
    input [7:0] biometric_hash,
    input scan,
    output reg valid_voter,
    output reg [2:0] voter_index
);

reg [7:0] voter_db [0:7];

integer i;

initial begin
    voter_db[0] = 8'b10110011;
    voter_db[1] = 8'b01010101;
    voter_db[2] = 8'b11001100;
    voter_db[3] = 8'b00110011;
    voter_db[4] = 8'b11100011;
    voter_db[5] = 8'b00011110;
    voter_db[6] = 8'b10101010;

end

always @(*) begin
    valid_voter = 0;
    voter_index = 0;

    if(scan) begin
        for(i = 0; i < 8; i = i + 1) begin
            if(biometric_hash == voter_db[i]) begin
                valid_voter = 1;
                voter_index = i;
            end
        end
    end
end

endmodule