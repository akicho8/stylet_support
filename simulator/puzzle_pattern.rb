DATA.readlines.each do |line|
  if md = line.match(/(\d+):(.*)/)
    num, blocks = md.captures
    num = num.to_i
    blocks = blocks.scan(/\w+/).collect{|str|
      str = str.gsub(/\d+/, "")
      # p str
      {
        "ao" => "b",
        "a" => "g",
        "mizu" => "r",
        "mu" => "c",
        "k" => "y",
        "o" => "o",
        "m" => "p",
      }[str]
    }
    puts "#{num} #{blocks}"
  end
end
__END__
001: ao2 a2 mizu2
002: mizu1 mu4 ao3
003: k1 mu4 o3
004: mu4 ao3 mizu2
005: mizu1 mizu1 o3
006: mu3 mizu2 o3
007: mizu2 a1 ao3
008: mizu1 o4 ao3
009: m2 o4 k1
010: a2 ao2 o4
011: mu2 o4 ao3
012: o4 mizu1 k1
013: o4 mu3 ao2
014: mizu1 mizu1 ao2
015: k1 ao3 o3
016: mu4 a2 mizu2
017: mizu1 o1 ao3
018: mizu1 mu4 o3
019: mizu1 o4 k1
020: o4 mu3 ao3
021: o4 o3 mu4
022: m1 m2 mu4
023: a2 m1 ao3
024: m2 k1 mu4
025: ao2 m2 k1
026: o3 ao1 mizu2
027: ao2 m2 mizu2
028: ao2 o1 ao2
029: k1 mu4 o3
030: o4 a2 ao3
031: o3 mu4 mu4
032: k1 mu2 k1
033: mizu1 o1 o4
034: o4 mu4 ao3
035: ao2 o1 ao3
036: m1 o4 k1
037: mu4 ao3 mu4
038: m2 o4 mu4
039: mu4 ao1 o3
040: mu2 mu3 ao2
041: ao2 ao3 mu4
042: mizu1 mu3 k1
043: k1 a2 mu4
044: a1 o3 mu4
045: mizu1 m2 o4
046: m2 a2 mu4
047: mizu1 m1 ao3
048: a2 m1 k1
049: o1 a1 k1
050: o4 mu3 o4
051: mu2 m2 o4
052: ao3 a2 ao2
053: mu4 m1 o3
054: o4 a2 ao2
055: ao1 o1 mu4
056: mizu1 mu2 o4
057: o3 a2 mu4
058: ao2 mu4 ao3
059: o3 m1 ao3
060: k1 ao1 mu4
061: o1 k1 mu4
062: mizu1 mu2 o4
063: o3 o1 ao3
064: o4 mizu1 ao3
065: k1 mu3 o4
066: o2 m2 k1
067: a2 ao2 ao3
068: m2 ao2 k1
069: mu4 ao1 mu4
070: mu2 mizu1 ao2
071: k1 o2 ao2
072: mizu1 a2 mu4
073: mu4 ao2 ao3
074: mizu1 a2 ao3
075:  ao4 mizu1 o4
076: k1 a2 mu4 mizu2
077: m2 mu3 ao2 mu4
078: m2 mu3 a1 k1
079: mu2 m2 mizu1 k1
080: mizu1 o4 mu3 k1
081: mizu1 a2 mu4 o3
082:  ao4 mizu1 mu4 ao3
083: k1 k1 mu4 mu4
084: o4 ao2 mu4 mizu2
085: k1 m1 mu2 o4
086: k1 ao3 o1 o3
087: mu3 a2 ao2 k1
088: k1 mu4 o3 mizu2
089: mizu1 mu3 m2 mu4
090: mizu1 mizu1 ao2 o3
091: o4 mizu1 o4 ao3
092: k1 ao1 mu4 mizu2
093: mizu1 m1 a1 o3
094: ao2 mu2 o4 k1
095: k1 o4 ao2 mu4
096: a1 ao3 k1 mu4
097: o4 ao2 ao1 mu4
098: m2 mizu1 o4 o3
099: m2 ao2 mizu1 k1
100: ao1 a2 ao3 ao3
101: mu2 o4 m1 o3
102: mu2 o2 o4 ao2
103: ao2 mizu1 o4 ao3
104: mizu1 a2 ao3 o3
105: a1 mu3 ao2 mizu2
106: a2 ao2 m2 o3
107: mu2 o4 ao3 mizu2
108: o3 mizu1 k1 mu4
109: o3 a2 mu4 ao3
110: mu2 mizu1 ao3 ao3
111: o4 k1 o3 mu4
112: mu2 o4 ao1 mu4
113: m2 a2 ao2 o4
114: m2 mu2 a2 mu4
115: mu2 a1 ao2 k1
116: a2 mizu1 ao2 mu4
117: k1 mu3 a2 k1
118: o4 ao2 m1 mu4
119: k1 mu2 mu3 ao2
120: ao2 mu2 ao2 ao3
121: ao3 ao3 o3 mu4
122: a2 o4 mu3 mizu2
123: m2 mu3 a2 ao2
124: mu2 o4 mu4 o3
125: mu3 ao2 o4 o3
126: mizu1 k1 mu2 o4
127: o4 mu4 o4 k1
128: m2 ao2 a2 mu4
129: mu2 ao4 m2 mizu2
130: mizu1 k1 mu3 ao2
131: o4 ao2 mu4 mizu2
132: k1 ao1 a2 o3
133: m2 mu3 mizu1 ao2
134: mu2 o4 ao2 o4
135: mu2 a2 k1 o3
136: a2 ao2 o4 mu4
137: a2 mizu1 ao2 mu4
138: mizu1 o4 ao2 k1
139: m2 ao3 o4 mizu2
140: mizu1 mu2 ao2 o3
141: mu2 o4 a2 k1
142: mu3 a2 ao2 mu4
143: mu2 o2 ao2 k1
144: k1 mizu1 a2 o3
145: a2 ao3 ao2 mu4
146: mizu1 o4 ao2 mu4
147: mu3 mizu1 ao2 o4
148: a2 a2 mu2 ao3
149: mizu1 mu3 ao2 ao3
150: m1 o3 ao3 mu4
151: o4 a2 m2 ao3
152: o4 k1 ao3 mu4
153: a2 mu2 m2 k1
154: k1 mu4 ao1 mizu2
155: ao3 ao4 mu2 o3
156: mu2 k1 ao3 o3
157: o4 m1 ao3 mu4
158: m2 o4 a2 mu4
159: k1 mu3 ao2 o3
160: mu2 a1 ao2 o3
161: m2 o4 mu4 o3
162: ao2 a2 mu2 o3
163: mu2 m2 mu4 o3
164: k1 o2 ao2 ao2
165: m2 mizu1 mu3 ao2
166: m2 o4 o1 mu4
167: ao2 m2 mu3 ao3
168: m2 mu2 k1 mu4
169: mu3 mizu1 m2 o4
170: mu4 o3 a2 mizu2
171: mu4 ao2 m2 mizu2
172: mizu1 mu2 a2 ao3
173: mu2 o4 ao3 ao3
174: m2 mu3 ao2 mu4
175: k1 mu2 ao2 ao3
176: mu2 ao2 mizu1 o3
177: ao2 mizu1 mu3 ao2
178: o4 mizu1 mu2 ao3
179: o3 m2 mu3 k1
180: mizu1 mu3 o4 k1
181: a1 mizu1 mu2 ao2
182: k1 ao4 m2 mu4
183: k1 ao3 a1 o3
184: a2 m1 ao3 mu4
185: m2 ao1 a2 o3
186: k1 ao3 m2 o4 mu4
187: ao2 m1 mu2 o4 mizu2
188: mizu1 ao2 ao1 mu3 o3
189: a2 mu2 m2 ao3 mu4
190: mu3 a2 ao2 o3 mizu2
191: a2 ao2 mu4 ao3 o3
192: ao3 o3 k1 mu2 mizu2
193: ao2 k1 mu2 a2 o3
194: k1 k1 mu3 a2 ao2
195: mu4 ao1 mu4 o4 mizu2
196: ao3 o1 m1 mu2 mizu2
197: ao2 mu2 mizu1 m1 o4
198: m2 mizu1 o4 m1 mu4
199: ao2 a1 mu4 mu4 k1
200: a2 o2 mu3 a2 ao2
