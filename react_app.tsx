import Papa from 'papaparse';
import { useMemo, useState, FormEvent } from 'react';
import { Printer, LogOut, User, BookOpen, GraduationCap, Award, AlertCircle } from 'lucide-react';
import { rawCsvData } from './data';

interface Subject {
  name: string;
  attendance: string;
  exam: string;
  totalScore: string;
  percentage: string;
  grade: string;
}

interface StudentResult {
  id: string;
  name: string;
  stage: string;
  subjects: Subject[];
  totalScore: string;
  totalGrade: string;
}

function parseData(): StudentResult[] {
  const parsed = Papa.parse(rawCsvData, { header: true, skipEmptyLines: true });
  return parsed.data.map((row: any) => {
    const subjectNames = [
      'لاهوت العقيدي',
      'التربوي',
      'لاهوت الطقسي',
      'العهد الجديد',
      'العهد القديم'
    ];

    const subjects: Subject[] = subjectNames.map(subj => ({
      name: subj,
      attendance: row[`${subj} - حضور`] || '-',
      exam: row[`${subj} - إمتحان`] || '-',
      totalScore: row[`${subj} - إجمالي (درجات)`] || '-',
      percentage: row[`${subj} - إجمالي (نسبة مئوية)`] || '-',
      grade: row[`${subj} - التقدير`] || '-'
    }));

    return {
      id: row['رقم الكارنيه'],
      name: row['إسم الطالب'],
      stage: row['المرحلة'],
      subjects,
      totalScore: row['النتيجة الكلية - درجات'] || '-',
      totalGrade: row['النتيجة الكلية - تقدير'] || 'لم يحدد',
    };
  });
}

export default function App() {
  const students = useMemo(() => parseData(), []);
  const [loggedInStudent, setLoggedInStudent] = useState<StudentResult | null>(null);
  const [loginId, setLoginId] = useState('');
  const [error, setError] = useState('');

  const handleLogin = (e: FormEvent) => {
    e.preventDefault();
    if (!loginId.trim()) {
      setError('يرجى إدخال رقم الكارنيه');
      return;
    }

    const student = students.find(s => s.id === loginId.trim());
    if (student) {
      setLoggedInStudent(student);
      setError('');
    } else {
      setError('رقم الكارنيه غير صحيح أو غير موجود');
    }
  };

  const handleLogout = () => {
    setLoggedInStudent(null);
    setLoginId('');
    setError('');
  };

  const handlePrint = () => {
    window.print();
  };

  if (!loggedInStudent) {
    return (
      <div className="min-h-screen bg-[#f5f5f0] flex items-center justify-center p-4">
        <div className="bg-white rounded-3xl shadow-sm border border-[#e6e6de] w-full max-w-md overflow-hidden">
          <div className="bg-[#6b705c] p-8 text-center text-white border-b border-[#d9d9cf]">
            <GraduationCap className="mx-auto w-16 h-16 mb-4 opacity-100 text-[#f5f5f0]" />
            <h1 className="text-3xl font-bold mb-2">منظومة النتائج</h1>
            <p className="text-[#f5f5f0]/80">قم بتسجيل الدخول لمعرفة نتيجتك</p>
          </div>
          <div className="p-8">
            <form onSubmit={handleLogin} className="space-y-6">
              <div>
                <label htmlFor="cardId" className="block text-sm font-semibold text-[#333533] mb-2">
                  رقم الكارنيه
                </label>
                <input
                  type="text"
                  id="cardId"
                  value={loginId}
                  onChange={(e) => setLoginId(e.target.value)}
                  className="w-full px-4 py-3 rounded-lg border border-[#e6e6de] focus:border-[#6b705c] focus:ring-2 focus:ring-[#6b705c]/20 outline-none transition-all"
                  placeholder="أدخل رقم الكارنيه الخاص بك (مثال: 1001)"
                  dir="ltr"
                  style={{ textAlign: 'right' }}
                />
              </div>
              
              {error && (
                <div className="flex items-center gap-2 text-red-600 bg-red-50 border border-red-100 p-3 rounded-lg text-sm">
                  <AlertCircle className="w-5 h-5 shrink-0" />
                  <p>{error}</p>
                </div>
              )}

              <button
                type="submit"
                className="w-full bg-[#6b705c] hover:bg-opacity-90 text-white font-bold py-3 px-4 rounded-full transition-colors flex items-center justify-center gap-2"
              >
                <span>عرض النتيجة</span>
              </button>
            </form>
          </div>
        </div>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-[#f5f5f0] print:bg-white p-4 sm:p-8">
      <div className="max-w-4xl mx-auto space-y-6">
        
        {/* Header Actions */}
        <div className="flex items-center justify-between no-print mb-6 border-b border-[#d9d9cf] pb-6">
          <button
            onClick={handleLogout}
            className="px-6 py-2.5 rounded-full border border-[#6b705c] text-[#6b705c] font-bold text-sm hover:bg-[#6b705c] hover:text-white transition-colors flex items-center gap-2"
          >
            <LogOut className="w-4 h-4 rtl:rotate-180" />
            <span>تسجيل خروج</span>
          </button>
          <button
            onClick={handlePrint}
            className="px-8 py-2.5 rounded-full bg-[#6b705c] text-white font-bold text-sm flex items-center gap-2 hover:opacity-90 transition-opacity"
          >
            <Printer className="w-4 h-4" />
            <span>تصدير النتيجة PDF</span>
          </button>
        </div>

        {/* Official Header for Print */}
        <div className="hidden print:block text-center mb-8 border-b border-[#d9d9cf] pb-6">
          <h1 className="text-3xl font-bold text-[#333533] mb-2">بيان درجات طالب</h1>
          <p className="text-[#6b705c]">الفصل الدراسي الحالي</p>
        </div>

        {/* Student Info Card */}
        <div className="bg-white rounded-3xl shadow-sm border border-[#e6e6de] p-6 print-shadow-none">
          <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
            <div className="flex items-start gap-4">
              <div className="w-12 h-12 bg-[#6b705c] rounded-xl flex items-center justify-center text-white shadow-sm shrink-0">
                <User className="w-6 h-6" />
              </div>
              <div>
                <p className="text-sm text-[#6b705c] font-medium mb-1">اسم الطالب</p>
                <p className="font-bold text-[#333533] text-xl">{loggedInStudent.name}</p>
                <div className="mt-1 flex items-center gap-2 text-sm">
                  <span className="text-[#6b705c]">رقم الكارنيه: {loggedInStudent.id}</span>
                </div>
              </div>
            </div>
            
            <div className="flex items-start gap-4">
              <div className="w-12 h-12 bg-[#cb997e] rounded-xl flex items-center justify-center text-white shadow-sm shrink-0">
                <BookOpen className="w-6 h-6" />
              </div>
              <div>
                <p className="text-sm text-[#6b705c] font-medium mb-1">المرحلة الدراسية</p>
                <p className="font-bold text-[#333533] text-lg leading-relaxed">{loggedInStudent.stage}</p>
              </div>
            </div>
          </div>
        </div>

        {/* Subjects Table */}
        <div className="bg-white rounded-3xl shadow-sm border border-[#e6e6de] overflow-hidden print-shadow-none flex flex-col">
          <div className="p-6 border-b border-[#e6e6de] bg-white">
            <h2 className="text-lg font-bold text-[#333533] flex items-center gap-2">
              <Award className="w-5 h-5 text-[#6b705c]" />
              تفاصيل المواد
            </h2>
          </div>
          <div className="overflow-x-auto w-full">
            <table className="w-full text-right">
              <thead className="bg-[#fcfcf9] border-b border-[#f0f0e6]">
                <tr>
                  <th className="p-4 text-[#6b705c] font-bold text-sm">المادة</th>
                  <th className="p-4 text-[#6b705c] font-bold text-sm text-center">حضور</th>
                  <th className="p-4 text-[#6b705c] font-bold text-sm text-center">إمتحان</th>
                  <th className="p-4 text-[#6b705c] font-bold text-sm text-center">إجمالي (درجات)</th>
                  <th className="p-4 text-[#6b705c] font-bold text-sm text-center">نسبة مئوية</th>
                  <th className="p-4 text-[#6b705c] font-bold text-sm text-center">التقدير</th>
                </tr>
              </thead>
              <tbody className="divide-y divide-[#f0f0e6]">
                {loggedInStudent.subjects.map((subject, index) => (
                  <tr key={index} className="hover:bg-[#fcfcf9] transition-colors bg-white">
                    <td className="p-4 font-medium text-[#333533]">{subject.name}</td>
                    <td className="p-4 text-center font-mono text-[#333533]">{subject.attendance}</td>
                    <td className="p-4 text-center font-mono text-[#333533]">{subject.exam}</td>
                    <td className="p-4 text-center font-mono font-bold text-[#333533]">{subject.totalScore}</td>
                    <td className="p-4 text-center font-mono text-[#6b705c]">{subject.percentage}</td>
                    <td className="p-4 text-center">
                      <span className={`inline-flex items-center px-2.5 py-1 rounded text-xs font-bold ${
                        subject.grade.includes('راسب') 
                          ? 'bg-red-50 text-red-700' 
                          : subject.grade.includes('ممتاز') || subject.grade.includes('جيد')
                          ? 'bg-emerald-50 text-emerald-700'
                          : 'bg-[#f0f0e6] text-[#6b705c]'
                      }`}>
                        {subject.grade}
                      </span>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </div>

        {/* Total Score Footer */}
        <div className="bg-white rounded-3xl shadow-sm border border-[#d9d9cf] p-6 flex flex-col md:flex-row items-center justify-between print-shadow-none">
          <div className="flex flex-col">
            <p className="text-[#6b705c] font-medium mb-1">النتيجة النهائية</p>
            <div className="flex items-baseline gap-2">
              <span className="text-4xl font-bold text-[#333533]">{loggedInStudent.totalScore}</span>
              <span className="text-[#cb997e] font-bold">درجة</span>
            </div>
          </div>
          <div className="mt-4 md:mt-0 text-right md:text-left">
            <p className="text-[#6b705c] font-medium mb-2">التقدير العام</p>
            <span className="inline-flex items-center px-6 py-2 rounded-lg text-xl font-bold bg-[#fcfcf9] text-[#6b705c] border border-[#e6e6de]">
              {loggedInStudent.totalGrade}
            </span>
          </div>
        </div>

      </div>
    </div>
  );
}
