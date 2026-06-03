import matplotlib.pyplot as plt

results = {}

with open("results.txt") as f:
    for line in f:
        name,value = line.strip().split("=")
        results[name] = int(value)

candidates = list(results.keys())
votes = list(results.values())

plt.bar(candidates,votes)

plt.title("Election Results")
plt.xlabel("Candidates")
plt.ylabel("Votes")

plt.show()