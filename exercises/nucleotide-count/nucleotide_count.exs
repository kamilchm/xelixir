defmodule NucleotideCount do
  @nucleotides [?A, ?C, ?G, ?T]

  def count([], _), do: 0
  
  @doc """
  Counts individual nucleotides in a NucleotideCount strand.

  ## Examples

  iex> NucleotideCount.count('AATAA', ?A)
  4

  iex> NucleotideCount.count('AATAA', ?T)
  1
  """
  @spec count([char], char) :: non_neg_integer
  def count(strand, nucleotide) do
    Enum.count(strand, fn(c) -> c == nucleotide end)
  end

  @doc """
  Returns a summary of counts by nucleotide.

  ## Examples

  iex> NucleotideCount.histogram('AATAA')
  %{?A => 4, ?T => 1, ?C => 0, ?G => 0}
  """
  def histogram([]) do
    Enum.reduce(@nucleotides, %{}, fn(n, h) -> Map.put(h, n, 0) end)
  end

  @spec histogram([char]) :: map
  def histogram(strand) do
    Enum.filter(strand, &Enum.member?(@nucleotides, &1))
    |> Enum.reduce(histogram([]), fn(n, h) -> Map.put(h, n, h[n] + 1) end)
  end
end
